module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do

        get 'customers' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
                             
          JSONResult.new(true, Customer.all)          
        end

        params do
          requires :id, type:Integer, desc: "Id of the customer, assign to 0 when creating new"
          requires :name, type:String, desc: "Name of customer"
          requires :phone, type:String, desc: "phone"
          requires :address, type:String, desc: "address"
          requires :email, type:String, desc: "Email"
        end        
        post 'customer/save' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          customer = Customer.find_by(:id => params[:id])
          
          if customer
            if Customer.where("LOWER(email) = ? AND id != ?", params[:email].downcase(), params[:id]).first
              return JSONResult.new(false, "EMAIL_EXISTED")
            end
            
            customer.name = params[:name]
            customer.phone = params[:phone]
            customer.address = params[:address]
            customer.email = params[:email].downcase()
            customer.updated_by = admin_user.username
            customer.save
          else
            if Customer.where("LOWER(email) = ?", params[:email].downcase()).first
              return JSONResult.new(false, "EMAIL_EXISTED")
            end
            
            customer = Customer.create(:name => params[:name],
                                       :phone => params[:phone],
                                       :address => params[:address],
                                       :email => params[:email].downcase(),
                                       :created_by => admin_user.username)
          end
          
          JSONResult.new(true, customer)
        end

        params do
          requires :id, type:Integer, desc: "ID of a customer"
        end
        get 'customer/:id/del' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          customer = Customer.find_by(:id => params[:id])
          if customer
            customer.destroy
          end
          
          JSONResult.new(true, nil)
        end
         
      end
    end
  end
end