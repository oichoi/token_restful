class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all.order(created_at: :desc)#新しい順
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @product }
  end

  def search#検索
    @products = Product.all.order(created_at: :desc)#新しい順
    if params[:title]
    @products2=@products.where(['title LIKE ?', "%#{params[:title]}%"])
    end
    render json: { status: 'SUCCESS',  data: @products2 }
  end

  def upload
    raise ArgumentError, 'invalid params' if params[:img].blank? || params[:title].blank?
    @product = Product.create(img: params[:img])
    @product.title = params[:title]
    @product.content = params[:content]
    @product.price = params[:price]
    @product.save!

    render json: {
        title: @product.title,
        content: @product.content,
        price: @product.price,
        img: @product.img.url
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:img, :title, :content, :price, :token)
    end
end
