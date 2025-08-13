module FindOrCreate
  extend ActiveSupport::Concern

  # def self.f1
  #   name.split("_").map(&:capitalize).join(" ")
  # end

  included do

  end
  
  # def self.exists?(struct)
  #   #puts "INTO EXISTS"
  #   if IDENTITY_RELATIONSHIP == :any
  #     IDENTITY_COLUMNS.each do |identity_column|
  #       thing = self.where(identity_column => struct.send(identity_column)).first
  #       #debugger
  #       if thing
  #         #debugger
  #         return true, thing
  #       else
  #         return false, nil
  #       end
  #     end
  #   elsif IDENTITY_RELATIONSHIP == :all
  #     #thing = self.where().first
  #     if thing
  #       return true, thing
  #     else
  #       return false, nil
  #     end
  #     # to be written when it occurs
  #     # return true if self.where()
  #     # where_clauses = []
  #     # IDENTITY_COLUMNS.each do |identity_column|
  #     #   where_clauses << {identity_column => struct.send(identity_column)}
  #     # end
  #     # #raise where_clauses.inspect
  #     # obj = self.where(where_clauses.first).first
  #     # if obj
  #     #   return true, obj
  #     # end
  #     # return false, nil
  #   end
  # end

  #
  # fix this by passing in an identity_constant
  # 
  class_methods do
    
    #def self.exists?(struct)
    def exists?(struct)
      #puts "INTO EXISTS"
      if self::IDENTITY_RELATIONSHIP == :any
        self::IDENTITY_COLUMNS.each do |identity_column|
          thing = self.where(identity_column => struct.send(identity_column)).first
          #debugger
          if thing
            #debugger
            return 200, thing
          else
            return 500, nil
          end
        end
      elsif self::IDENTITY_RELATIONSHIP == :all
        #thing = self.where().first
        
        where_clauses = []
        self::IDENTITY_COLUMNS.each do |identity_column|
          where_clauses << {identity_column => struct.send(identity_column)}
        end
        where_clause = where_clauses.reduce Hash.new, :merge
        thing = self.where(where_clause).first
        if thing
          return 200, thing
        else
          return 500, nil
        end
        # to be written when it occurs 
        # return true if self.where()
        # where_clauses = []
        # IDENTITY_COLUMNS.each do |identity_column|
        #   where_clauses << {identity_column => struct.send(identity_column)}
        # end
        # #raise where_clauses.inspect
        # obj = self.where(where_clauses.first).first
        # if obj
        #   return true, obj
        # end
        # return false, nil
      end
    end

    #def self.find_or_create(struct)
    def find_or_create(struct)
      #debugger
      exists, thing = self.exists?(struct)
      #debugger
      return 200, thing if thing
      
      # test_obj = self.new
      # if test_obj.respond_to?(:date_created_at)
      # else
      #   # Save the date
      #   date_to_update = struct.date_created_at.to_time
      #   # Delete the date
      #   struct.delete_field!(:date_created_at)
      #   # pull that entry out of the open struct
      # end
      
      #debugger
      thing = self.new(struct.to_h)
      #debugger
      thing.save
      #debugger
      if thing.persisted?
        # if date_to_update
        # # monkey patch (ok no its not monkey patching technically but this feels like monkeys are involved)
        #   thing.update_column(:created_at, date_to_update)
        #   thing.update_column(:published_at, date_to_update) if thing.respond_to?(:published_at)
        # end
        return 200, thing
      else
        # todo need better error codes; more http link
        raise [500, thing.errors.full_messages.inspect].inspect
      end

    end
  end

end
