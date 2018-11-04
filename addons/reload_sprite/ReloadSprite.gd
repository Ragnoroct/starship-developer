tool
extends Sprite

var texture_path

# func _init():
#     self.connect("texture_changed", self, "_texture_changed")

func _ready():
    self.texture_path = texture.resource_path
    SpriteReloader.watch_sprite(self)
    
func reload_texture():
    var updated_texture = load_png(self.texture_path)
    self.set_texture(updated_texture)
    
func load_jpg(file):
    var jpg_file = File.new()
    jpg_file.open(file, File.READ)
    var bytes = jpg_file.get_buffer(jpg_file.get_len())
    var img = Image.new()
    var data = img.load_jpg_from_buffer(bytes)
    var imgtex = ImageTexture.new()
    imgtex.create_from_image(img)
    jpg_file.close()
    return imgtex
    
func load_png(file):
    var png_file = File.new()
    png_file.open(file, File.READ)
    var bytes = png_file.get_buffer(png_file.get_len())
    var img = Image.new()
    var data = img.load_png_from_buffer(bytes)
    var imgtex = ImageTexture.new()
    imgtex.create_from_image(img)
    png_file.close()
    return imgtex