module DB
  module MetaData
    attr_accessor :tables, :primary_keys, :foreign_keys, :column_info

    def initialize
      @db = DB::DbiSqlServer.new 
      
      populate
      
      sql_statements.each_key do |key|
        define_method("#{key}_for") do |table|
          send(key, table).select { |item| item[:table_name] == table_name(table) }
        end unless key == :tables
      end
    end
    
    def populate
      sql_statements.each do |key, value|
        instance_variable_set("@"+key.to_s, @db.fetch_all(value))				
      end
    end
    
    def is_join_table?(table)
      fks = foreign_keys_for table_name(table)
      fks.size > 1
    end
    
    def is_foreign_key?(column_info)
      fks = foreign_keys.select { |fk| fk[:table_name] == column_info[:table_name] and fk[:child_id] == column_info[:name]  }
      fks.size > 0
    end
    
    def table_name(table)
      table.is_a?(Hash) ? table[:name] : table
    end
    
    private
    
      def sql_statements 
        {
          :tables => "SELECT table_name as name FROM information_schema.Tables Where table_type='Base Table' ORDER BY table_name",
          :column_info => "select object_name(c.object_id) as table_name, c.column_id, c.name, type_name(system_type_id) as sql_type, max_length, is_nullable, precision, scale, 
                convert(bit,(Select COUNT(*) from sys.indexes as i 
                  inner join sys.index_columns as ic
                    on ic.index_id = i.index_id and ic.object_id = i.object_id 
                  inner join sys.columns as c2 on ic.column_id = c2.column_id and i.object_id = c2.object_id
                WHERE i.is_primary_key = 0 
                  and i.is_unique_constraint = 0 and ic.column_id = c.column_id and i.object_id=c.object_id)) as is_index,
                is_identity, 
                is_computed, 
                convert(bit,(Select Count(*) from sys.indexes as i inner join sys.index_columns as ic
                    on ic.index_id = i.index_id and ic.object_id = i.object_id 
                  inner join sys.columns as c2 on ic.column_id = c2.column_id and i.object_id = c2.object_id
                WHERE (i.is_unique_constraint = 1) and ic.column_id = c.column_id and i.object_id=c.object_id)) as is_unique
                from sys.columns as c
                WHERE object_name(c.object_id)  in (select table_name	FROM information_schema.Tables WHERE table_type = 'Base Table') 
                order by table_name",
          :primary_keys => "SELECT i.name AS index_name,ic.index_column_id,key_ordinal,c.name AS column_name,TYPE_NAME(c.user_type_id)AS column_type 
                      ,is_identity,OBJECT_NAME(i.object_id) as table_name FROM sys.indexes AS i INNER JOIN sys.index_columns AS ic ON 
                      i.object_id = ic.object_id AND i.index_id = ic.index_id INNER JOIN sys.columns AS c ON ic.object_id = c.object_id
                      AND c.column_id = ic.column_id WHERE i.is_primary_key = 1 order by table_name",
          :foreign_keys => "SELECT f.name AS foreign_key_name, object_name(f.parent_object_id) AS table_name , col_name(fc.parent_object_id, fc.parent_column_id) AS child_id
                      ,object_name (f.referenced_object_id) AS parent_table ,col_name(fc.referenced_object_id, fc.referenced_column_id) AS parent_id FROM sys.foreign_keys AS f
                      INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id where OBJECT_NAME(f.parent_object_id) not in ('sysdiagrams')  order by table_name"
         }
       end

  end
  
end