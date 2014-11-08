# -*- coding: utf-8 -*-
require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
    @ticket_params = {"event_name"=>"test", "datetime(1i)"=>"2014", "datetime(2i)"=>"11", "datetime(3i)"=>"7", "datetime(4i)"=>"07", "datetime(5i)"=>"38", "place"=>"", "price"=>"", "note"=>"", "user_id"=>"99"}
    @params = {"categories"=>nil, "tags"=>""}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should be redirected by new when user did not login" do
    get :new
    assert_response :redirect
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post(:create, ticket: @ticket_params, params: @params)
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket
    assert_response :success
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
