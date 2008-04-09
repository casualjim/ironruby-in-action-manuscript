# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class LightSpeedDataContext
  
  DEFAULT_REFERENCES = ["System.Linq", "Mindscape.LightSpeed.Linq"]
  
  def initialize(namespace, model_path, context_name)
    @namespace = namespace
    @model_path = model_path
    @context_name = context_name || "#{@namespace.split('.')[0]}DataContext"
    @entities = []
    @user_file_content = ""
    @should_read_user_file = true
  end
  
  def add_entity(entity)
    @entities << entity
  end
  
  def generate_files()
    generate_interface_file
    generate_file
    generate_user_stub_file
  end
  
  def add_interface_reference_to_project_file(doc)
      unless doc.elements.to_a('//Compile').any?{ |e| e.attributes['Include'] === "I#{@context_name}.cs"}
            
        u_el = Element.new "Compile"
        u_el.attributes["Include"] = "I#{@context_name}.cs"

        unless doc.elements['//Compile'].nil?
          parent = doc.elements['//Compile'].parent
        else
          parent = Element.new "ItemGroup" 
          doc.elements['//Project'] << parent
        end
        parent << u_el
      end
    end
  
  private
  
    def generate_file
      path = "#{@model_path}/#{@context_name}.lightspeed.cs"
      puts "creating lightspeed datacontext file: #{path}"
      File.open(path, 'w') do |f|
        f << create_file_content do |file_content, tabindex|
          @entities.each do |entity|
            if(Regexp.compile("IQueryable<#{entity}>\s+_#{entity.pluralize}").match(user_file_content).nil?)
                file_content << render_queryable(entity, tabindex)
            end
          end
        end
      end
    end
    
    def user_file_content
      user_path = "#{@model_path}/#{@context_name}.cs"
      if File.exists? user_path
        if @user_file_content.empty? && @should_read_user_file
            @user_file_content = File.open(user_path, 'r').read{ |f| f.read } 
            @should_read_user_file = false
        end
      end
      @user_file_content || ""
    end
    
    def generate_interface_file
      path = "#{@model_path}/I#{@context_name}.cs"
      puts "creating lightspeed datacontext interface file: #{path}"
      File.open(path, 'w') do |f|
        f << create_interface_file_content
      end
    end

    def generate_user_stub_file
      path = "#{@model_path}/#{@context_name}.cs"
      updates_project_file = false
      unless File.exists? path
        puts "creating user datacontext stub file: #{path}"
        updates_project_file = true
        File.open(path, 'w+') do |f|
          f << create_file_content
        end 
      end
      updates_project_file
    end

    def create_file_content
      file_content = ""

        DEFAULT_REFERENCES.each do |ref|
          file_content << "using #{ref};\n"
        end

        file_content << "\nnamespace #{@namespace}\n{\n"
        file_content << (block_given? ? "\tpublic partial class #{@context_name} : LightSpeedDataContext, I#{@context_name}" : "\tpublic partial class #{@context_name}")
        file_content << "\n\t{\n"

        yield file_content, 2 if block_given?

        file_content << "\t}\n}\n"
    end

    def create_interface_file_content
        file_content = ""
  
        DEFAULT_REFERENCES.each do |ref|
          file_content << "using #{ref};\n"
        end

        file_content << "\nnamespace #{@namespace}\n{\n"
        file_content << "\tpublic interface I#{@context_name}"
        file_content << "\n\t{\n"

        @entities.each do |entity|
          file_content << render_interface_queryable(entity, 2)
        end

        file_content << "\t}\n}\n"
    end

    def render_interface_queryable(entity, tabindex=0)
      tabs = ""
      result = ""
      0.upto(tabindex-1) { tabs << "\t" }

      result << "#{tabs}IQueryable<#{entity}> #{entity.pluralize}{ get; }\n"
    end


    def render_queryable(entity, tabindex = 0)
      tabs = ""
      result = ""
      0.upto(tabindex-1) { tabs << "\t" }

      result << "#{tabs}public virtual IQueryable<#{entity}> #{entity.pluralize}\n"
      result << "#{tabs}{\n#{tabs}\tget { return Query<#{entity}>(); }\n#{tabs}}\n"
    end
  
end
