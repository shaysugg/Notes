func exampleOF(_ description: String, _ example: () -> Void) {
    print("------ \(description) ------- \n")
    example()
    print("------\n\n")
}