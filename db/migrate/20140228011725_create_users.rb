class CreateUsers < ActiveRecord::Migration
  def change

  	create_table		:users do |t| 
  		t.string		:username
  		t.string		:email
  		t.string		:fname
  		t.string		:mname
  		t.string		:lname
  		t.string		:gender
  		t.date			:birthday
 	
 	end
  end
end
