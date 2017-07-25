#!/usr/bin/env ruby
#
# source/syntax.rb
# Since there are so much similarity on each syntax node, and there is no
# good syntax tree generator tool found, so it may be a good idea to write
# a utility to generate all the syntax nodes' source file from yacc's rule.
#
# Created by oziroe on July 25, 2017.
#
yacc_text = File.read(ARGV[0])
rule_text = yacc_text[/.*%%([^%]*)%%.*/, 1]

def remove_code_blocks(text)
    level = 0
    text.chars.map do |c|
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
pure_rule = remove_code_blocks(rule_text)

rules = pure_rule.split(';').select{ |r| r.strip != '' }
rules_map = {}
rules.each do |rule_text|
    splited = rule_text.split(/(?<!'):(?!')/)
    name, content = splited[0].strip, splited[1]
    rules = content.split('|').map{ |r| r.strip }
    rules_map[name] = rules
end

output_folder = ARGV[1]
rules_map.each do |name, rules|
    file_name = File.join(output_folder, "#{name}.h")
    File.open(file_name, 'w') do |file|
        file << "Hello!"
    end
end
