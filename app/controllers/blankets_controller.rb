class BlanketsController < ApplicationController
  def new
    if user_signed_in?
      @booking = current_user.bookings.build
      render partial: 'blankets/booking_form'
    else
      if params[:booking].present?
        session[:booking_params] = booking_params
      end
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @booking = current_user.bookings.build(booking_params)
    else
      redirect_to new_user_session_path and return unless session[:booking].present?

      @user = User.new(user_params)
      if @user.save
        sign_in(@user)
        @booking = @user.bookings.build(session[:booking_params])
      else
        render 'new'
        return
      end
    end

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render 'new'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:item_type, :quantity, :date, :time)
  end

  def user_params
    params.require(:user).permit(:name, :address, :phone_number)
  end
end
