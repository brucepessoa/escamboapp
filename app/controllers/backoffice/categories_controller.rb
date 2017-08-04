class Backoffice::CategoriesController < BackofficeController
  	def index
  		@categories = Category.all
  	end

  	def new
  		@category = Category.new
  	end

  	def create
  		@category = Category.new(params_category)
  		if @category.save
  			redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) foi cadastrada com sucesso!" 
  		else
  			render :new
  		end	
  	end

  	def edit
  		set_category
  		# ou coloca no inicio before_action :set_category, only: [:edit, :update]
  		#e apaga essa linha. Só vai executar o set_category no edit e no update
  	end

  	def update
  		set_category
  		if @category.update(params_category)
  			redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) foi atualizada com sucesso!" 
  		else
  			render :edit
  		end
  	end

  	private

  	def set_category
  		@category = Category.find(params[:id])
  	end

  	def params_category
  		params.require(:category).permit(:description)
  	end
end
