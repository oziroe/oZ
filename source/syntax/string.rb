#
# source/syntax/string.rb
# Some add-on to built-in String class.
#
# Created by oziroe on July 26, 2017.
#

class String
    def indent(level)
        self.split("\n").map do |line|
            "    " * level + line
        end.join("\n")
    end

    def declaration(rules_type, additional_types, style=:value)
        if rules_type.include?(self)
            {
                :value        => "#{rules_type[self]} #{self}_value;",
                :default      => "#{rules_type[self]} #{self}",
                :struct       => "struct _#{rules_type[self]} *#{self}",
                :struct_colon => "struct _#{rules_type[self]} *#{self};",
                :struct_value => "struct _#{rules_type[self]} *#{self}_value;",
            }[style]
        elsif additional_types.include?(self)
            val = self.downcase
            {
                :value      => "#{additional_types[self]} #{val}_value;",
                :default    => "#{additional_types[self]} #{val}",
                :struct     => "#{additional_types[self]} #{val}",
                :struct_colon => "#{additional_types[self]} #{val};",
                :struct_value => "#{additional_types[self]} #{val}_value;",
            }[style]
        else
            ""
        end
    end

    def rules_map
        rule_text = self[/.*%%([^%]*)%%.*/, 1]
        def rule_text.remove_code_blocks
            level = 0
            self.chars.map do |c|
                if c == '{'
                    level += 1
                    ''
                elsif c == '}'
                    level -= 1
                    ''
                else
                    level == 0 ? c : ''
                end
            end.join
        end
        pure_rule = rule_text.remove_code_blocks

        rules = pure_rule.split(';').select{ |r| r.strip != '' }
        rules_map = Hash.new
        rules.each do |rule_text|
            splited = rule_text.split(':', 2)
            name, content = splited[0].strip, splited[1].strip
            rules = content.split('|').map(&:strip)
            rules_map[name] = rules.map do |rule|
                rule_splited = rule.match(/\/\*(.*)\*\/(.*)/m)
                rule_name, rule_content =
                    rule_splited[1].strip, rule_splited[2].strip
                {:type => rule_name, :rule => rule_content.split}
            end
        end
        rules_map
    end
end
