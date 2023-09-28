//
//  TagView.swift
//  Custom_chips_Demo
//
//  Created by vignesh kumar c on 28/09/23.
//

import SwiftUI

struct TagView: View {
    var maxLimit: Int
   @Binding var tags: [Tag]
    
    var title: String  = "Add some Tags"
    var fontSize: CGFloat = 16
    
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.callout)
                .foregroundColor(Color("tag"))
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    ForEach(getRows(), id:\.self) { rows in
                        HStack(spacing: 6) {
                            ForEach(rows) { row in
                                RowView(tag: row)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
                .padding(.vertical)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("tag").opacity(0.2), lineWidth: 2)
            )
            .animation(.easeInOut, value: tags)
            .overlay(
                Text("\(getSize(tags: tags))/\(maxLimit)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color("tag"))
                    .padding(12), alignment: .bottomTrailing
            )
        }

    }
    
    @ViewBuilder
    
    func RowView(tag: Tag) -> some View {
        Text(tag.text)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
            
                Capsule()
                    .fill(Color.white)
            )
            .foregroundColor(Color("bg"))
            .lineLimit(1)
            .contentShape(Capsule())
            .contextMenu {
                Button("Delete") {
                    tags.remove(at: getIndex(tag: tag))
                }
                .animation(.easeInOut, value: tags)
            }
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    func getIndex(tag: Tag) -> Int {
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        
        return index
    }
    
    func getRows() ->[[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
        
        tags.forEach { tag in
            totalWidth += (tag.size + 40)
            
            if totalWidth > screenWidth {
                
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
                
            } else {
                currentRow.append(tag)
            }
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
}

#Preview {
    ContentView()
}


func addText(tags: [Tag], text: String, fontSize: CGFloat, maxLimit: Int, completion: @escaping (Bool, Tag) ->()) {
  
    let font = UIFont.systemFont(ofSize: fontSize)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    
    let tag = Tag(text: text, size: size.width)
    if (getSize(tags: tags) + text.count ) < maxLimit {
        completion(false, tag)
    } else {
        completion(true, tag)
    }
}

func getSize(tags: [Tag]) -> Int {
    var count: Int = 0
    tags.forEach { tag in
        count += tag.text.count
    }
    return count
}
