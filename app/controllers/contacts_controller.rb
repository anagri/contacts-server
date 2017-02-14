class ContactsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  resource_description do
    api_base_url '/contacts'
    formats ['html','json']
    short_description 'RESTful API to manage contacts'
    error 404, "Not Found"
    error 422, "Validation Errors"
    error 500, "Internal Server Error"
  end

  # GET /contacts
  # GET /contacts.json
  api :GET, '/index.html'
  api :GET, '.json'
  error 200, "OK"
  description 'Get all the contacts in json/html format'
  example <<EXAMPLE
[
  {
  "id": 1,
  "first_name": "Amitabh",
  "last_name": "Bachchan",
  "email": "ab@bachchan.com",
  "phone_number": "+919980123412",
  "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610",
  "favorite": false,
  "created_at": "2016-05-29T10:10:10.995Z",
  "updated_at": "2016-05-29T10:10:10.995Z"
  },
  {
  "id": 2,
  "first_name": "Shahrukh",
  "last_name": "Khan",
  "email": "srk@kingkhan.com",
  "phone_number": "+919980432143",
  "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/008/original/srk.jpg?1464516694",
  "favorite": false,
  "created_at": "2016-05-29T10:11:34.134Z",
  "updated_at": "2016-05-29T10:11:34.134Z"
  }
]
EXAMPLE
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  api :GET, '/{id}'
  api :GET, '/{id}.json'
  error 200, "OK"
  param :id, Fixnum, :desc => "Contact ID", :required => false
  description 'Get contacts detail'
  example <<EXAMPLE
{
  "id": 1,
  "first_name": "Amitabh",
  "last_name": "Bachchan",
  "email": "ab@bachchan.com",
  "phone_number": "+919980123412",
  "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610",
  "favorite": false,
  "created_at": "2016-05-29T10:10:10.995Z",
  "updated_at": "2016-05-29T10:10:10.995Z"
}
EXAMPLE
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  api :POST, ''
  api :POST, '.json'
  description 'Create new contact'
  error 201, 'Contact successfully created'
  error 422, "Validation Errors"
  example <<EXAMPLE
{
  "id": 1,
  "first_name": "Amitabh",
  "last_name": "Bachchan",
  "email": "ab@bachchan.com",
  "phone_number": "+919980123412",
  "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610",
  "favorite": false,
  "created_at": "2016-05-29T10:10:10.995Z",
  "updated_at": "2016-05-29T10:10:10.995Z"
}
EXAMPLE
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: build_error(@contact.errors), status: :unprocessable_entity }
      end
    end
  end

  def build_error(errors)
    result = []
    errors.each do |k, v|
      result << "#{k.to_s.gsub('_', ' ').capitalize} #{v}"
    end
    {errors: result}
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  api :PUT, '/{id}'
  api :PUT, '/{id}.json'
  error 200, "OK"
  param :id, Fixnum, :desc => "Contact ID", :required => false
  description 'Update contacts detail'
  example <<EXAMPLE
{
  "id": 1,
  "first_name": "Amitabh",
  "last_name": "Bachchan",
  "email": "ab@bachchan.com",
  "phone_number": "+919980123412",
  "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610",
  "favorite": false,
  "created_at": "2016-05-29T10:10:10.995Z",
  "updated_at": "2016-05-29T10:10:10.995Z"
}
EXAMPLE
  def update
    puts("new update request")
    puts(contact_params)
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        puts(@contact.errors)
        format.html { render :edit }
        format.json { render json: build_error(@contact.errors), status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :profile_pic, :favorite)
  end
end
