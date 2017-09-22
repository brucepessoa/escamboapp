class Backoffice::AdminsController < BackofficeController
  	def index
  		@admins = Admin.all
  	end

    def new
  		@admin = Admin.new
  	end

  	def create
  		@admin = Admin.new(params_admin)
  		if @admin.save
  			redirect_to backoffice_admins_path, notice: " O Administrador (#{@admin.email}) foi cadastrado com sucesso!" 
  		else
  			render :new
  		end	
  	end

  	def edit
  		set_admin
  		# ou coloca no inicio before_action :set_admin, only: [:edit, :update]
  		#e apaga essa linha. Só vai executar o set_admin no edit e no update
  	end

  	def update
  		set_admin
  		#permite alterar os dados do administrador sem rescrever a senha. Ele apaga os atributos 
  		#password e password_confirmation do hash enviado pelo update, caso esteja em branco. 
  		#Com isso eu consigo alterar o email sem re-digitar as senha.
		pwd = params[:admin][:password]
		pwd_confirmation = params[:admin][:password_confirmation]
		if pwd.blank? && pwd_confirmation.blank? #se estiver em branco, apaga e update
			params[:admin].delete(:password)
			params[:admin].delete(:password_confirmation)
		end	

  		if @admin.update(params_admin)
  			redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi atualizado com sucesso!" 
  		else
  			render :edit
  		end
  	end

  	def destroy
  		set_admin
  		if @admin.destroy
			redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi apagado com sucesso!"   			
  		else
  			render :index		
		end
  	end


  	private

  	def set_admin
  		@admin = Admin.find(params[:id])
  	end

  	def params_admin
  		params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  	end
end
