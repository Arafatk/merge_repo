module Rubyplot
  module Scripting
    module Plots
      class StackedBarZ < LazyBase
        def initialize(data, bar_colors: :default, bar_width: :default,
                       bar_gap: :default, bar_edge: :default,
                       bar_edge_color: :default, bar_edge_width: :default)
                       ## To Do add default Bar edge colors
          super()
          @bar_colors = bar_colors
          @bar_gap = bar_gap
          @bar_width = bar_width
          @bar_edge = bar_edge
          @bar_edge_color = bar_edge_color
          @bar_edge_width = bar_edge_width

          @bar_gap = 0 if @bar_gap == :default
          @bar_width = 1 if @bar_width == :default
          @bar_edge_width = 0.053 if @bar_edge_width == :default
          @bar_edge = true if @bar_edge == :default
          @bar_colors = CONTRASTING_COLORS if @bar_colors == :default
          @bar_edge_color = COLOR_INDEX[:black] if @bar_edge_color == :default
<<<<<<< HEAD
          @bar_edge_color = COLOR_INDEX[bar_edge_color] if @bar_edge_color.is_a? Symbol
=======
          @bar_edge_color = COLOR_INDEX[marker_color] if @bar_edge_color.is_a? Symbol
>>>>>>> fa09d6f01eaa3723220ee0416e84a79672afbb9c
          @data = data
          # All this will be repurposed
        end

        def call(state)
          # for Lazy plots the state has been passed  in the plotspace call
          # every lazy plot will have a call function rather than inherting it
          # tasks wont be pushed, rather they will be instantiated and called directly
          (0..@data[0].size - 1).to_a.each do |i|
            bar_heights = @data.map{|row| row[i]}
            order = bar_heights.map.with_index.sort.map(&:last).reverse
            bar_heights = bar_heights.sort.reverse
            (0..bar_heights.size-1).to_a.each do |j|
              if @bar_edge
                SetFillColorIndex.new(inqcolorfromrgb(@bar_edge_color)).call
                SetFillInteriorStyle.new(GR_FILL_INTERIOR_STYLES[:solid]).call
                FillRectangle.new(i * (@bar_width + @bar_gap) - @bar_edge_width,
                             i * (@bar_width + @bar_gap) + @bar_width + @bar_edge_width,
                             state.origin[1], bar_heights[j] + 2 * @bar_edge_width).call
              end
              bar_color = @bar_colors[order[j]]
              bar_color = COLOR_INDEX[bar_color] if bar_color.is_a? Symbol
              SetFillColorIndex.new(inqcolorfromrgb(bar_color)).call
              SetFillInteriorStyle.new(GR_FILL_INTERIOR_STYLES[:solid]).call
              FillRectangle.new(i * (@bar_width + @bar_gap),
                           i * (@bar_width + @bar_gap) + @bar_width,
                           state.origin[1], bar_heights[j]).call
            end
          end
        end
      end
    end
  end
end
