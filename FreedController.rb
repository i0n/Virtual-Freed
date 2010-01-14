# FreedController.rb
# virtual_freed
#
# Created by i0n on 02/01/2010.

class FreedController < NSWindowController

	attr_accessor :message

	def awakeFromNib
		virtual_freed = NSBundle.mainBundle.pathForResource('virtual_freed', :ofType => 'mp3')
		@start_sound = NSSound.alloc.initWithContentsOfFile(virtual_freed, :byReference => false)
		laters = NSBundle.mainBundle.pathForResource('laters', :ofType => 'mp3')
		@stop_sound = NSSound.alloc.initWithContentsOfFile(laters, :byReference => false)
		@start_sound.play
		@sound_files = NSBundle.mainBundle.pathsForResourcesOfType( "mp3" , inDirectory:"app_sounds")
		random_sound
		@freed_active = false
	end
	
	def activate_freed(sender)
		if @freed_active == false
			random_sound
			@sound.play
			start_timer
			@freed_active = true
		end
	end
	
	def next_freedism(sender)
		if @freed_active == true
			@sound.stop
			random_sound
			@sound.play
			@count = 60
		else
			self.message.stringValue = "It's no good poking him until he's been activated."
		end
	end
	
	def stop_freed(sender)
		@count = nil
		@timer = nil
		@freed_active = false
		@stop_sound.play
		self.message.stringValue = "Freeds rampage of terror has been halted."
	end
		
	def start_timer
		if @timer == nil
			@timer = NSTimer.scheduledTimerWithTimeInterval 1, target: self, selector: 'reset_timer:', userInfo: nil, repeats: true
			@count = 60
		end
	end
	
	def reset_timer(timer=nil)
		if @count > 0
			@count -= 1
		else
			@count = 60
			random_sound
			@sound.play
		end
		self.message.stringValue = "Social hand grenade in: #{@count}"
	end
	
	def random_sound
		random_number = rand(@sound_files.count)
		@sound = NSSound.alloc.initWithContentsOfFile(@sound_files[random_number], :byReference => false)
	end
	
end
