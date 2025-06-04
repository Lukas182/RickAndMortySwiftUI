import SwiftUI

struct FilterButtonByType: View {
    
    var filter : Character.Status
    @Binding var selectedFilter : Character.Status?
    
    var body: some View {
        Button {
            if selectedFilter == filter {
                selectedFilter = nil
                return
            }
            selectedFilter = filter
        } label : {
            Text("\(filter.rawValue)")
                .bold()
                .foregroundStyle(filter == selectedFilter ? .white : Color.black)
                .padding(6)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(filter == selectedFilter ? Color.green : Color.white)
                        }
                }
        }
        .buttonStyle(.plain)
    }
}
