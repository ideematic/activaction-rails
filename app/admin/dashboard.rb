ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        small 'Activ\'Action admin. Pour ajouter un utilisateur en admin, aller dans Users et changer le champ admin.'
      end
    end

    div class: 'panel_contents attributes_table' do
      table do

        tr do
          td { 'Moyenne de compétences apprises / personnes grâce à AA en 2 mois' }
          td { '%.2f' % AdminStats.average_new_skills_per_user(2.month.ago) }
        end
        tr do
          td { 'Moyenne de compétences apprises / personnes grâce à AA en 6 mois' }
          td { '%.2f' % AdminStats.average_new_skills_per_user(6.month.ago) }
        end
        tr do
          td { 'nombre de membres organisant des events/projet' }
          td { AdminStats.user_count_with_events }
        end
        tr do
          td { 'nombre de membres participant à des event/projets' }
          td { AdminStats.user_count_with_attended_events }
        end
        tr do
          td { 'nombre events /projets organisés par des membres' }
          td { AdminStats.member_projects.count }
        end
        tr do
          td { 'nombre de membres qui intéragissent/alimentent le forum' }
          td { '?' }
        end
        tr do
          td { 'moyenne de nouveaux contacts dans leur réseau' }
          td { '?' }
        end
        tr do
          td { 'nombre de participants qui assistent aux 3 ateliers : Activ\'Boost, Activ\'Drink et troisième atelier (en construction)' }
          td { 'Boost: %s, Drink: %s, ?: %s' % [AdminStats.user_count_for_category(1), '?', '?'] }
        end
        tr do
          td { 'nombre d\'events co-organisés avec différents membres' }
          td { '?' }
        end
        tr do
          td { 'nombre de témoignages /retours d’expériences spontannés' }
          td { '?' }
        end
        tr do
          td { 'pourcentage des participants augmentent le taux de remplissage de leur Activ’Portrait après un atelier' }
          td { '?' }
        end
        tr do
          td { 'pourcentage des participants augmentent le taux de remplissage de leur  “motivations”  dans l’Activ’Portrait' }
          td { '?' }
        end
        tr do
          td { 'temps d’apprentissage d’une compétence' }
          td { '?' }
        end
        tr do
          td { 'nombre de personnes qui ont téléchargé l’Activ’Portrait depuis le site' }
          td { '?' }
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
