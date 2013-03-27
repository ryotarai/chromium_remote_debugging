module ChromiumRemoteDebugging
  module Types
    class RemoteObject
      attr_reader :class_name, :description, :object_id, :subtype, :type, :value
      def initialize(opts)
        @class_name = opts["className"]
        @description = opts["description"]
        @object_id = opts["objectId"]
        @subtype = opts["subtype"]
        @type = opts.fetch("type")
        @value = opts["value"]
      end
    end
  end
end
