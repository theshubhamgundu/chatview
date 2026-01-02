# ChatView Connect

Developed by **shubham gundu**

[![Build](https://github.com/theshubhamgundu/chatview/actions/workflows/flutter.yaml/badge.svg?branch=master)](https://github.com/theshubhamgundu/chatview/actions) [![chatview_connect](https://img.shields.io/pub/v/chatview_connect?label=chatview_connect)](https://pub.dev/packages/chatview_connect)

`chatview_connect` is a specialized wrapper for the [`chatview`][chatViewPackage] package, providing seamless integration with Database & Storage for your Flutter chat app.

_Check out other amazing projects by [shubham gundu](https://github.com/theshubhamgundu)!_

## Preview

| ChatList                                                                                                         | ChatView                                                                                                         |
|------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| ![ChatList_Preview](https://raw.githubusercontent.com/theshubhamgundu/chatview/main/preview/chatlist.gif) | ![ChatView Preview](https://raw.githubusercontent.com/theshubhamgundu/chatview/main/preview/chatview.gif) |

## Features

- **Easy Setup:** Integrate with the [`chatview`][chatViewPackage] package in 3 steps:
    1. Initialize the package by specifying the **Cloud Service** (e.g., Local/Mock).
    2. Set the current **User ID**.
    3. Widget-wise controllers to use it with the [`chatview`][chatViewPackage] package:
       1. For `ChatList` obtain the **`ChatListManager`**
       2. For `ChatView` obtain the **`ChatManager`**
- Supports **one-on-one** and **group chats** with **media uploads** *(audio not supported).*
- **Local Service Support:** Perfect for offline apps or rapid prototyping without a backend setup.

***Note:*** *Previously supported Firebase. Currently optimized for Local/Mock service and preparing for more providers.*

## Documentation

Visit the [GitHub Repository](https://github.com/theshubhamgundu/chatview) for detailed implementation instructions, usage examples, and advanced features.

## Installation

```yaml
dependencies:
  chatview_connect: <latest-version>
```

## Compatibility with [`chatview`][chatViewPackage]

| [`chatview`][chatViewPackage] version | `chatview_connect` version |
|---------------------------------------|----------------------------|
| `>=2.4.1 <3.0.0`                      | `0.0.1`                    |
| `>= 3.0.0`                            | `3.0.0`                    |

## Support

For questions, issues, or feature requests, [create an issue](https://github.com/theshubhamgundu/chatview/issues) on GitHub. We're happy to help and encourage community contributions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[chatViewPackage]: https://pub.dev/packages/chatview
