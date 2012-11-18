# -*- coding: utf-8 -*-
class ContactsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def send_email
    @contact_form = ContactForm.new params[:contact_form]

    if @contact_form.valid? && verify_recaptcha
      ContactMailer.contact(@contact_form).deliver
      redirect_to :root, notice: "Nous allons vous répondre dans les plus brefs délais !"
    else
      flash.now[:error] = 'Veuillez remplir tous les champs'
      render :new
    end
  end
end
