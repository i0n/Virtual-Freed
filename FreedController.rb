# FreedController.rb
# virtual_freed
#
# Created by i0n on 02/01/2010.
# Copyright 2010 Ian Web Designs. All rights reserved.

class FreedController < NSWindowController

	attr_accessor :message

	def awakeFromNib
#		Method for retreiving one file path from resources folder
#		cued_sound = NSBundle.mainBundle.pathForResource('Electro', :ofType => 'mp3')
		@sound_files = NSBundle.mainBundle.pathsForResourcesOfType( "mp3" , inDirectory:"")
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
		self.message.stringValue = "Freeds rampage of terror has been halted."
	end
		
	def start_timer
		if @timer == nil
			@timer = NSTimer.scheduledTimerWithTimeInterval 1, target: self, selector: 'reset_timer:', userInfo: nil, repeats: true
#			Although this 'rubyish' way of doing the above should work. It currently errors out...
#			@timer = IntervalTimer.new(1, :target => self, :selector => 'reset_timer:')
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
