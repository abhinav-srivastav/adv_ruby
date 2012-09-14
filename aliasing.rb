module MyModule
  def self.included(cls)
    def cls.chained_aliasing(org_met, prefix)
      original_method = "original_#{org_met}"
      alias_method original_method, org_met
      scope = "public"
      scope = "private" if self.private_method_defined?("#{org_met}")
      scope = "protected" if self.protected_method_defined?("#{org_met}")
       
      sym = ""
      if "#{org_met}".end_with?('?')
        sym = "?"
      elsif "#{org_met}".end_with?('!')
        sym = "!"
      end

      org_met = org_met.to_s.gsub(sym,"")  

      self.class_eval %{ #{scope}
        def #{org_met}#{sym}  
          puts '--logging start'
            #{original_method}
          puts "--logging end"
        end
      }
      alias_method "#{org_met}_with_#{prefix}#{sym}", "#{org_met}#{sym}"
      self.class_eval %{ #{scope}
        def #{org_met}_without_#{prefix}#{sym}
         #{original_method}
        end
      }
    end
  end
end

class Hello
  include MyModule
  def greet?
    puts Hello
  end
  chained_aliasing :greet?, :logger
end

say = Hello.new
say.greet?
say.greet_with_logger?
say.greet_without_logger?