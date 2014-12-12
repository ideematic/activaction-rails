class Label < ActiveRecord::Base

  def self.retrieve(label)
    entry = self.find_by_label(label)
    if !entry
      entry = Label.create! label: label, content: 'undefined'
    end
    entry.content.html_safe
  end
end
