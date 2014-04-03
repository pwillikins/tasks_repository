require 'rspec'
require 'tasks_repository'

describe TasksRepository do
  it "creates task items in a database" do
    db = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_database')
    db.create_table! :tasks_list do
      primary_key :id
      String :name
      Integer :priority
    end
    tasks = db[:tasks_list]

    list_of_tasks = TasksRepository.new(tasks)
    list_of_tasks.add('Task 1', 3)
    list_of_tasks.add('Task 2', 2)
    list_of_tasks.add('Task 3', 1)
    expect(list_of_tasks.list_all).to eq [{id: 1, name: 'Task 1', priority: 3},
                                          {id: 2, name: 'Task 2', priority: 2},
                                          {id: 3, name: 'Task 3', priority: 1}]
  end
end