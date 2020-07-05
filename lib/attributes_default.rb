require "attributes_default/version"

module AttributesDefault
  def self.included(base)
    base.instance_eval do
      def attributes_set_default_value(**options)
        class_variable_set('@@default_value_options', options)
      end
    end

    base.after_initialize :auto_set_default_value!, if: :new_record?

    base.class_eval do
      def auto_set_default_value!
        self.class.class_variable_get('@@default_value_options').each_pair do |k, v|
          # 避免生成的默认值是固定的，比如生成时间类的值的时候，需要在使用的地方定义一个 proc
          v = v.is_a?(Proc) ? v.call : v
          send("#{k}=", v) if send(k).nil?
        end
      end
    end
  end
end
