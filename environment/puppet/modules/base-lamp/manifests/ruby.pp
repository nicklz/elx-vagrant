class base-lamp::ruby {

    $packageList = [
        "ruby",
        "rubygems"
        ]

    package { $packageList: }

}