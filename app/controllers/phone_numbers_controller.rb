class PhoneNumbersController < InheritedResources::Base

  private

    def phone_number_params
      params.require(:phone_number).permit()
    end

end
