module SafeTimeout
  class Spawner

    def initialize(options={})
      @expiration = Time.now.to_f + options.fetch(:timeout, 0)
      @on_timeout = options.fetch(:on_timeout)
      @start_signal = File::ALT_SEPARATOR ? 'INT' : 'TRAP'
      @stop_signal = File::ALT_SEPARATOR ? 'TERM' : 'HUP'
    end

    def start(&block)
      original = Signal.trap(@start_signal, &@on_timeout) || 'DEFAULT'
      spawn_interrupter
      yield
    ensure
      Signal.trap(@start_signal, original)
      stop
    end

    def stop
      # Tell that child to stop interrupting!
      SafeTimeout.send_signal(@stop_signal, @child_pid)
    end

    def spawn_interrupter
      # Create a light-weight child process to notify this process if it is
      # taking too long
      bin = Gem.bin_path('safe_timeout', 'safe_timeout')
      @child_pid = Process.spawn(bin, Process.pid.to_s, @expiration.to_s)
      Process.detach(@child_pid)
    end

  end
end
