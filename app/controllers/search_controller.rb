class SearchController < ApplicationController
  layout "works"

  def search
    search_term = params[:q]

    is_integer = Integer(search_term) rescue false

    #Checking if search is an integer so it searched for year in the datafields
    sql_pdfs = {int: is_integer, data_field: is_integer ? "date" : "title", data_lookup: is_integer ? "=" : "LIKE"}
    sql_works = {int: is_integer, data_field: is_integer ? "opening_year" : "name", data_lookup: is_integer ? "=" : "LIKE"}

    if search_term.nil? || search_term.empty?
      @works, @articles = []
    else
      #Sql search created with the array data_fields
      @works = Work.where( sql_search( sql_works, search_term ), search_word_fuz(search_term, sql_works[:int]) )
      @articles = Pdf.where( sql_search( sql_pdfs, search_term ),  search_word_fuz(search_term, sql_pdfs[:int] ) )
      flash_error( search_term ) unless @works.any? || @articles.any?
    end

  end

  private

  def sql_search info, search_word
    "#{info[:data_field]} #{info[:data_lookup]} ?"
  end

  def search_word_fuz search_word, is_int
    is_int ? search_word : "%#{search_word}%"
  end

  def flash_error search_word
    flash[:notice] = "Intet matcher søgningen \"#{search_word}\", desværre"
  end

end
