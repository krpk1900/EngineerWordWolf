Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'views#top'
  get 'share',   to: 'views#share'
  get 'waiting', to: 'views#waiting'
  get 'play',    to: 'views#play'
  get 'vote',    to: 'views#vote'
  get 'result',  to: 'views#result'
end
