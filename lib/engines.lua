local fileselect = require "fileselect"

local orca_engine = {}
local NUM_SAMPLES = 36

function unrequire(name)
  package.loaded[name] = nil
  _G[name] = nil
end

-- Multiple engines aren't supported... yet
-- https://llllllll.co/t/orca/22492/148
engine.name = "PolyPerc"
-- unrequire('r/lib/r')
-- local R = require 'r/lib/r'
-- engine.name = 'R'
-- unrequire("timber/lib/timber_engine")
-- local Timber = include("timber/lib/timber_engine")
-- engine.name = "Timber"


function orca_engine.load_folder(file, add)
  -- if add then
  --   for i = NUM_SAMPLES - 1, 0, -1 do
  --     if Timber.samples_meta[i].num_frames > 0 then
  --       sample_id = i + 1
  --       break
  --     end
  --   end
  -- end

  -- Timber.clear_samples(sample_id, NUM_SAMPLES - 1)
  softcut.buffer_clear()

  local sample_id = 0
  local split_at = string.match( file, "^.*()/" )
  local folder = string.sub( file, 1, split_at )
  file = string.sub( file, split_at + 1 )

  local found = false
  for k, v in ipairs(fileselect.list) do
    if v == file then found = true end
    if found then
      if sample_id > 35 then
        print("Max files loaded")
        break
      end
      -- Check file type
      local lower_v = v:lower()
      if string.find( lower_v, ".wav" ) or string.find( lower_v, ".aif" ) or string.find( lower_v, ".aiff" ) then
        -- Timber.load_sample(sample_id, folder .. v)
        softcut.buffer_read_mono( folder .. v, 0, 1, -1, 1, sample_id )
        -- params:set( 'play_mode_' .. sample_id, 4 )
        sample_id = sample_id + 1
      else
        print("Skipped", v)
      end
    end
  end
end


function orca_engine.init()
  params:add_trigger("load_f", "+ Load Folder")
  params:set_action("load_f", function() 
    fileselect.enter( _path.audio, function( file )
      if file ~= "cancel" then
        orca_engine.load_folder( file, add )
      end
    end )
  end )

  -- synth


  -- timber
  --[[
  params:set_action('load_f', function() Timber.FileSelect.enter(_path.audio, function(file)
  if file ~= "cancel" then orca_engine.load_folder(file, add) end end) end)

  Timber.options.PLAY_MODE_BUFFER_DEFAULT = 3
  Timber.options.PLAY_MODE_STREAMING_DEFAULT = 3
  params:add_separator()
  Timber.add_params()
  for i = 0, NUM_SAMPLES - 1 do
    local extra_params = {
      {type = "option", id = "launch_mode_" .. i, name = "Launch Mode", options = {"Gate", "Toggle"}, default = 1, action = function(value)
        Timber.setup_params_dirty = true
      end},
    }
    params:add_separator()
    Timber.add_sample_params(i, true, extra_params)
    --params:set('play_mode_' .. i, 4)
    --params:set('amp_env_sustain_' .. i, 0)
  end
  --]]

  -- softcut
  softcut.reset()
  audio.level_cut(1)
  audio.level_adc_cut(1)
  audio.level_eng_cut(1)
  for i=1, 6 do
    softcut.level(i,1)
    softcut.level_input_cut(1, i, 1.0)
    softcut.level_input_cut(2, i, 1.0)
    softcut.pan(i, 0.5)
    softcut.play(i, 0)
    softcut.rate(i, 1)
    softcut.loop_start(i, 0)
    softcut.loop_end(i, 36)
    softcut.loop(i, 0)
    softcut.rec(i, 0)
    softcut.fade_time(i,0.02)
    softcut.level_slew_time(i,0.01)
    softcut.rate_slew_time(i,0.01)
    softcut.rec_level(i, 1)
    softcut.pre_level(i, 1)
    softcut.position(i, 0)
    softcut.buffer(i,1)
    softcut.enable(i, 1)
    softcut.filter_dry(i, 1)
    softcut.filter_fc(i, 0)
    softcut.filter_lp(i, 0)
    softcut.filter_bp(i, 0)
    softcut.filter_rq(i, 0)
  end


end

return orca_engine
