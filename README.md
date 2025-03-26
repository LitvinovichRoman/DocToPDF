# DocToPDF Converter

A Swift package for converting DOCX files to PDF format.

## Requirements

- iOS 13.0+ / macOS 10.15+
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager

1. In Xcode, select File > Add Packages...
2. Enter the repository URL:

```swift
dependencies: [
    .package(url: "https://github.com/LitvinovichRoman/DocToPDF")
]
```

## Usage

```swift
import DOCXConverter

// Initialize the converter
let converter = DOCXConverter()

// Convert DOCX to PDF
do {
    let docxURL = URL(fileURLWithPath: "path/to/your/document.docx")
    let pdfURL = URL(fileURLWithPath: "path/to/output.pdf")
    
    try converter.convert(docxURL: docxURL, to: pdfURL)
    print("Conversion successful!")
} catch {
    print("Conversion failed: \(error)")
}
```

## License

This project is licensed under the MIT License.
