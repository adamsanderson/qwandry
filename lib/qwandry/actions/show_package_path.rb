require 'qwandry/action/success_exitstatus'

module Qwandry
  module Actions
    class PrintPackagePath
      include Qwandry::Action::SuccessExitstatus

      attr_accessor :package

      def run
        puts package.paths
      end
      
      alias_method :exit_status, :success_exitstatus # Assuming puts always succeeds
    end
  end
end
