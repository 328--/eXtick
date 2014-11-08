# -*- coding: utf-8 -*-
require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
    @ticket_params = {"event_name"=>"test", "datetime(1i)"=>"2014", "datetime(2i)"=>"11", "datetime(3i)"=>"7", "datetime(4i)"=>"07", "datetime(5i)"=>"38", "place"=>"", "price"=>"", "note"=>"", "user_id"=>"99"}
    @params = {"categories"=>nil, "tags"=>""}
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post(:create, ticket: @ticket_params, params: @params)
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  # test "should update ticket" do
  #   puts @ticket
  #   patch(:update, params: @params)
  #   assert_redirected_to ticket_path(assigns(:ticket))
  # end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket
    end
    
    assert_redirected_to tickets_path
  end
end
