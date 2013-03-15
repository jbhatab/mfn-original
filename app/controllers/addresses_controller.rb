class AddressesController < ApplicationController
  before_filter :load_addressable



  def edit
    @address = @addressable.address
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = @addressable.address.new(params[:address])
  end

  # PUT /addresses/1
  # PUT /addresses/1.json
  def update
    @address = @addressable.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address = @addressable.address
    @address.destroy

    respond_to do |format|
      format.html { redirect_to @addressable }
      format.json { head :no_content }
    end
  end

private

  def load_addressable
    resource, id = request.path.split('/')[1, 2]
    @addressable = resource.singularize.classify.constantize.find(id)
  end

end
