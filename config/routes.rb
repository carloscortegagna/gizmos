Gizmos::Engine.routes.draw do

  resources :gizmos, :only => [:new, :edit, :destroy], :path => 'gizmos' do
    get 'edit_content', :to => 'gizmos#edit_content', on: :member
    get 'move_up', :to => 'gizmos#move_up', on: :member
    get 'move_down', :to => 'gizmos#move_down', on: :member
    get 'success', :to => 'gizmos#success', on: :collection
    get 'buttons_toggle', to: 'gizmos#buttons_toggle', on: :collection
  end

end
