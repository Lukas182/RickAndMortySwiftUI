import SwiftUI

struct EpisodiesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let episodies : [String: [Episode]]
    
    var body: some View {
        
        List {
            ForEach(episodies.keys.sorted(), id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(episodies[key] ?? []) { episode in
                        VStack(alignment: .leading){
                            Text(episode.name)
                                .bold()
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text(episode.episode.suffix(3))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding(.top, 0.3)
    }
}

#Preview {
    EpisodiesView(episodies: [:])
}
