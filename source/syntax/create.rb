#
# source/syntax/create.rb
# Generate function that creates syntax tree node struct.
#
# Created by oziroe on July 26, 2017.
#
def syntax_tree_create(target, rule, rules_type, additional_types, impl)
    terms_decl = rule[:rule].reject{ |r| r.start_with?("'") }.map{ |term|
        term.declaration(rules_type, additional_types, style=:default) }
        .reject(&:empty?).join(", ")
    sig = "struct _#{rules_type[target]} *create_#{target}_#{rule[:type]}(" +
        "#{terms_decl})"
    if impl == false
        return "#{sig};"
    end

    return "#{sig} {}"  # TODO: fill it.
end
