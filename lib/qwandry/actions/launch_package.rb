require 'qwandry/action/success_exitstatus'

module Qwandry
  module Actions
    # Opens package in an editor
    class LaunchPackage
      include Qwandry::Action::SuccessExitstatus

      attr_accessor :package
      attr_accessor :editor

      attr_accessor :exit_status

      def run
        self.exit_status = if launch_package
          success_exitstatus
        else
          # Exit with the status returned by the process used to open the package
          last_child_process_exitstatus
        end
      end
      
      private
      
      def launch_package
        launcher = Qwandry::Launcher.new
        launcher.editor = editor
        
        launcher.launch(package)
      end
      
      def last_child_process_exitstatus
        $?.exitstatus
      end
    end
  end
end
