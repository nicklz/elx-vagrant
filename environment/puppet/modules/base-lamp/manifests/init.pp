class base-lamp {

    class{'base-lamp::apt-get-update': stage => first }
    class{'base-lamp::configuration-actions': stage => last }
}
