ActiveAdmin.register WikiPage do
  permit_params :url, :content, :public
end
