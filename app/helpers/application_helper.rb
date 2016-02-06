module ApplicationHelper
    def full_title(title)
        base_title = 'Twitter'
        if title == ''
            base_title
        else base_title + ': ' + title
        end
    end
    
end
