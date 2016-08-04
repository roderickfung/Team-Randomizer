require 'sinatra'
require 'sinatra/reloader'
require 'faker'

enable :sessions

get '/' do

erb :index, layout: :default
end

post '/' do
  @num = session[:num] = params[:num].to_i
  $arr = session[:array] = params[:array]
  @array = params[:array].gsub(", ",",").split(",").shuffle
  @cal = @array.length.to_i / @num
  if @array.length > @num && params[:type] == 'team'
    @ans = @array.each_slice(@cal).to_a
    (@ans[0] << @ans[-1][0]; @ans.pop ) if @ans[-1].length < 3
  elsif @array.length >= @num && params[:type] == 'ppl'
    @ans = @array.each_slice(@num).to_a
  else
    @ans = "Not enough people"
  end
  erb :index, layout: :default
end
