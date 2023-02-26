Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: redirect('/generate_uuid')
  get 'generate_uuid', to: 'views#generate_uuid'
  get 'top',           to: 'views#top'
  get 'share',         to: 'views#share'
  get 'waiting',       to: 'views#waiting'
  get 'play',          to: 'views#play'
  get 'vote',          to: 'views#vote'
  get 'result',        to: 'views#result'
end
