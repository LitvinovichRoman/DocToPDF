import Foundation
import PDFKit
import UIKit

public class PDFRenderer {
    private let pageRect: CGRect
    private let margin: CGFloat = 50
    
    public init(pageRect: CGRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)) { // A4 size
        self.pageRect = pageRect
    }
    
    public func render(content: DocumentContent) -> PDFDocument {
        let pdfDocument = PDFDocument()
        
        // Создаем PDF контекст
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, pageRect, nil)
        UIGraphicsBeginPDFPage()
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return pdfDocument
        }
        
        context.translateBy(x: margin, y: margin)
        
        var currentY: CGFloat = 0
        let lineHeight: CGFloat = 20
        
        // Рендерим параграфы
        for paragraph in content.paragraphs {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12)
            ]
            
            let textRect = CGRect(x: 0, y: currentY, width: pageRect.width - 2 * margin, height: lineHeight)
            paragraph.text.draw(in: textRect, withAttributes: attributes)
            
            currentY += lineHeight
        }
        
        // Рендерим таблицы
        for table in content.tables {
            guard !table.rows.isEmpty else { continue }
            
            currentY += lineHeight
            
            let cellWidth: CGFloat = (pageRect.width - 2 * margin) / CGFloat(table.rows[0].count)
            let cellHeight: CGFloat = 30
            
            for (rowIndex, row) in table.rows.enumerated() {
                for (colIndex, cell) in row.enumerated() {
                    let cellRect = CGRect(
                        x: CGFloat(colIndex) * cellWidth,
                        y: currentY + CGFloat(rowIndex) * cellHeight,
                        width: cellWidth,
                        height: cellHeight
                    )
                    
                    // Рисуем границы ячейки
                    context.stroke(cellRect)
                    
                    // Рисуем текст
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 10)
                    ]
                    
                    let textRect = cellRect.insetBy(dx: 5, dy: 5)
                    cell.draw(in: textRect, withAttributes: attributes)
                }
            }
            
            currentY += CGFloat(table.rows.count) * cellHeight
        }
        
        UIGraphicsEndPDFContext()
        
        if let pdfData = data as Data?,
           let newPDFDocument = PDFDocument(data: pdfData) {
            return newPDFDocument
        }
        
        return pdfDocument
    }
} 
