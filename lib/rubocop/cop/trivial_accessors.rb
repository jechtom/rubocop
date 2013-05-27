# encoding: utf-8

module Rubocop
  module Cop
    class TrivialAccessors < Cop
      MSG = 'Use attr_%s to define trivial %s methods.'

      def on_def(node)
        _, args, body = *node

        kind = if body.type == :ivar
                 'reader'
               elsif args.children.size == 1 && body.type == :ivasgn &&
                   body.children[1].type == :lvar
                 'writer'
               end
        if kind
          add_offence(:convention, node.loc.keyword.line,
                      sprintf(MSG, kind, kind))
        end

        super
      end
    end
  end
end
