# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |n|
  Topic.create!(
    title: "Topic #{n + 1}"
  )
end

10.times do |n|
  Blog.create!(
    title: "Title ##{n + 1}",
    body: "#{n + 1} Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, "\
    'totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt '\
    'explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur '\
    'magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia '\
    'dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et '\
    'dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam '\
    'corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure '\
    'reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum '\
    'fugiat quo voluptas nulla pariatur?',
    topic_id: Topic.last.id
  )
end

5.times do |n|
  Skill.create!(
    title: "Skill #{n + 1}",
    percentage: 5 * (n + 2)
  )
end

8.times do |n|
  Project.create!(
    title: "Project title ##{n + 1}",
    subtitle: 'Ruby on Rails',
    body: "#{n + 1} Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, "\
    'totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt '\
    'explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur '\
    'magni dolores eos qui ratione voluptatem sequi nesciunt.',
    main_image: 'https://via.placeholder.com/600x400',
    thumb_image: 'https://via.placeholder.com/350x200'
  )
end

1.times do |n|
  Project.create!(
    title: "Project title ##{n + 1}",
    subtitle: 'React',
    body: "#{n + 1} Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, "\
    'totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt '\
    'explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur '\
    'magni dolores eos qui ratione voluptatem sequi nesciunt.',
    main_image: 'https://via.placeholder.com/600x400',
    thumb_image: 'https://via.placeholder.com/350x200'
  )
end

3.times do |n|
  Project.last.technologies.create!(
    name: "Technology #{n + 1}"
  )
end
