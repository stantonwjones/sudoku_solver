class Grid < Array
    def clone
        Grid.new( self.map { |row| row.clone } )
    end
end