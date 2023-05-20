## `@dynamicMemberLookup`
It often becomes handy if we wrap a *child* class into a *parent* class and we want to access *child* properties directly from *parent* class
``` Swift
struct Blog {
    let title: String
    let url: URL
}

@dynamicMemberLookup
struct Blogger {
    let name: String
    let blog: Blog

    subscript<T>(dynamicMember keyPath: KeyPath<Blog, T>) -> T {
        return blog[keyPath: keyPath]
    }
}
```