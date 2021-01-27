class Pokemon

    attr_reader :id, :db
    attr_accessor :name, :type

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        pokemon = Pokemon.new(name: name, type: type, db: db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
        db.execute(sql, pokemon.name, pokemon.type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
    end

    def self.find(id_number, db)
        pokemon = db.execute("SELECT * FROM pokemon WHERE id == #{id_number};")[0]
        Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
    end

end
