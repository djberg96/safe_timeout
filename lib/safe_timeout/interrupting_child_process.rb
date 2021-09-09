module SafeTimeout
  class InterruptingChildProcess

    def initialize(ppid, expiration)
      @ppid = ppid.to_i
      @expiration = expiration.to_f
      @start_signal = File::ALT_SEPARATOR ? 'INT' : 'TRAP'
      @stop_signal = File::ALT_SEPARATOR ? 'TERM' : 'HUP'

      abort "Invalid pid to monitor: #{@ppid}" if @ppid == 0
      abort "Invalid expiration: #{@expiration}" if @expiration == 0.0
    end

    def notify_parent_of_expiration
      SafeTimeout.send_signal(@start_signal, @ppid)
    end

    def wait_for_timeout
      Signal.trap(@stop_signal) { exit 0 }

      sleep [@expiration - Time.now.to_f, 0.1].max

      notify_parent_of_expiration
    end

  end
end
