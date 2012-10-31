require './app'

namespace :assets do
  desc "Precompile all assets"
  task precompile: [:compile, :copy_images]

  desc "Compile CSS and JS assets"
  task :compile do
    puts "Compiling assets:"
    sprockets = Application.settings.sprockets

    # Additional sprockets config
    sprockets.logger = Logger.new('/dev/null')
    sprockets.css_compressor = :yui
    sprockets.js_compressor = :uglifier

    # Compile and write assets
    asset_path = File.join(Application.root, 'assets')
    asset_path_segments = asset_path.split('/').length
    assets = ['application.js', 'application.css']
    path = File.join(Application.root, 'public', 'assets')
    FileUtils.mkdir_p path
    assets.each do |asset_name|
      # Find all assets with the current name in the folder
      Pathname.new(asset_name).dirname.to_s.gsub(asset_path, '').split('/', 3).slice(2)
      files = Dir.glob(File.join(asset_path, '**', "#{asset_name}*"))
      files.each do |file|
        # Extract relative path of asset, with compiled filename
        relative_asset_name = Pathname.new(file).dirname.to_s.split('/')
        relative_asset_name = relative_asset_name.slice(asset_path_segments + 1, relative_asset_name.length - asset_path_segments - 1)
        if relative_asset_name.nil?
          relative_asset_name = asset_name
        else
          relative_asset_name = File.join('', relative_asset_name, asset_name)
        end
        # Remove starting /
        relative_asset_name = relative_asset_name.gsub(/^\//, '')

        # Find the asset and write to file
        asset = sprockets[relative_asset_name.gsub(/^\//, '')]
        next if asset.nil?
        compiled_name = relative_asset_name.split('.').insert(-2, 'min').join('.')
        compiled_path = Pathname.new(path).join(compiled_name)
        asset.write_to(compiled_path)

        puts "  -> #{relative_asset_name}"
      end
    end
  end

  desc "Copy images to asset folder"
  task :copy_images do
    puts "Copying images:"
    source_path = File.join(Application.settings.root, 'assets', 'images')
    destination_path = File.join(Application.settings.root, 'public', 'assets')
    Dir.glob("#{source_path}/**/**.*").each do |name|
      name = name.gsub(source_path, '')
      source_name = File.join(source_path, name)
      destination_name = File.join(destination_path, name)
      FileUtils.mkdir_p(Pathname.new(destination_name).dirname)
      FileUtils.cp(source_name, destination_name)
      puts "  -> #{name}"
    end
  end
end