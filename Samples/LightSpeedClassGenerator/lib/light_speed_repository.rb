

class LightSpeedRepository

  include DB::MetaData

  def initialize
    super
  end
  
  def to_light_speed_meta_data
    tables.collect do |table|
      col_infos = column_info_for table[:name]
      field_infos = col_infos.collect do |col_info|
        {
          :name => col_info[:name],
          :sql_type => col_info[:sql_type],
          :max_length => col_info[:max_length],
          :is_nullable => col_info[:is_nullable],  
          :precision => col_info[:precision],
          :is_foreign_key => is_foreign_key?(col_info)
        }
      end
      
      { 
        :table_name => table[:name], 
        :class_name => table[:name].camelize,
        :fields = field_infos 
      }
    end
  end
  
  def conventionalize
    if needs_conventionalising?
      
      tables.each do |table|
        @db.execute_non_query build_sql_string_for(table)
      end
      
      populate
    end
  end
  
  def needs_conventionalising?
    result = false
    tables.each do |table|
      puts "Table #{table[:name]}"
      pks = primary_keys_for table[:name]
      puts = "Size: #{pks.size}, col_name: #{pks[0][:column_name]}"
      result = (pks.size != 1 || pks[0][:column_name] != "Id") unless result
    end
    result
  end
  
# require 'config/boot'
# ls = LightSpeedRepository.new
# ls.conventionalize_database
  
  private 
  
    def build_sql_string_for(table)
      pks = primary_keys_for table[:name]
      sql =""
      case pks.size 
      when 0
        sql = add_primary_key_to(table[:name])
      when 1
        sql = "EXECUTE sp_rename N'dbo.#{table[:name]}.#{pks[0][:column_name]}', N'Id', 'COLUMN' " unless pks[0][:column_name] == "Id"
      else
        sql = migrate_to_single_primary_key(table[:name], pks)
      end
                
      sql
    end
  
    
    
    def migrate_to_single_primary_key(table, pks)
      sql = ""
      pks.collect { |pk| pk[:index_name]  }.uniq!.each do |index|
        sql << "ALTER TABLE dbo.#{table} DROP CONSTRAINT #{index}\n"
      end
      sql << add_primary_key_to(table)
      sql
    end
    
    def add_primary_key_to(table)
      sql = "ALTER TABLE dbo.#{table} ADD Id uniqueidentifier NOT NULL ROWGUIDCOL;\n"
      sql << add_primary_key_constraints_to(table)
      sql
    end
    
    def add_primary_key_constraints_to(table)
      "ALTER TABLE dbo.#{table} ADD CONSTRAINT DF_#{table}_Id DEFAULT (newid()) FOR Id
        ALTER TABLE dbo.#{table} ADD CONSTRAINT PK_#{table} PRIMARY KEY CLUSTERED(Id) WITH( 
          STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]"
    end

end  
  
